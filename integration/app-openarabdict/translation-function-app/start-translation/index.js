const df = require("durable-functions");

module.exports = async function (context, req)
{
    context.log("Bindings:", JSON.stringify(context.bindings, null, 2));

    const client = df.getClient(context);

    const instanceId = "translation-instance";
    const existing = await client.getStatus(instanceId);

    context.log(JSON.stringify(existing));
}