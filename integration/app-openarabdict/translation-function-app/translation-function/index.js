const mod = require("@aczwink/openarabdict-translator");
const { BlobServiceClient } = require("@azure/storage-blob");
const os = require("os");
const path = require("path");

const databasePath = os.tmpdir();

async function AcquireLock(context)
{
    const connectionString = process.env.AzureWebJobsStorage;
    const containerName = process.env.ACPLATFORM_INT_CONTAINER_NAME;
    const blobName = "translation-lock";

    const blobServiceClient = BlobServiceClient.fromConnectionString(connectionString);
    const containerClient = blobServiceClient.getContainerClient(containerName);
    const blockBlobClient = containerClient.getBlockBlobClient(blobName);

    await blockBlobClient.upload("", 0, { overwrite: true });

    const leaseClient = blockBlobClient.getBlobLeaseClient();
    await leaseClient.acquireLease(-1);

    context.log("Acquired lease");

    return leaseClient;
}

async function DownloadBlobToFile(context, blobName)
{
    const connectionString = process.env.AzureWebJobsStorage;
    const containerName = process.env.ACPLATFORM_INT_CONTAINER_NAME;

    const filePath = path.join(databasePath, blobName);

    const blobServiceClient = BlobServiceClient.fromConnectionString(connectionString);
    const containerClient = blobServiceClient.getContainerClient(containerName);
    const blobClient = containerClient.getBlobClient(blobName);

    context.log(`Downloading blob ${blobName} to ${filePath}...`);

    await blobClient.downloadToFile(filePath);

    context.log("Blob download finished");
}

async function UploadFileToBlob(context, blobName)
{
    const connectionString = process.env.AzureWebJobsStorage;
    const containerName = process.env.ACPLATFORM_INT_CONTAINER_NAME;
    const filePath = path.join(databasePath, blobName);

    const blobServiceClient = BlobServiceClient.fromConnectionString(connectionString);
    const containerClient = blobServiceClient.getContainerClient(containerName);
    const blockBlobClient = containerClient.getBlockBlobClient(blobName);

    context.log(`Uploading ${filePath} to blob ${blobName}...`);

    await blockBlobClient.uploadFile(filePath);

    context.log("Upload finished");
}

async function TranslateStep(context)
{
    await DownloadBlobToFile(context, "en.json");
    
    const count = await mod.TranslateDict({
        databasePath,
        maxTranslations: 100,
        targetLanguage: process.env.ACPLATFORM_INT_TRANSLATION_LANGUAGE,
    });
    
    await UploadFileToBlob(context, "de.json");
    await UploadFileToBlob(context, "mapping_en2de.json");

    return count < 100;
}

module.exports = async function (context, msg)
{
    const lease = await AcquireLock(context);
    
    try
    {
        const isFinished = await TranslateStep(context);
        if(!isFinished)
            context.bindings.queueOutput = {};
    }
    finally
    {
        await lease.releaseLease();
    }
};