const df = require("durable-functions");

module.exports = async function (context, req)
{
    const client = df.getClient(context);
    const instanceId = "translation-instance";

    const existing = await client.getStatus(instanceId);

    context.log(existing);
}