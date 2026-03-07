resource "azurerm_eventgrid_event_subscription" "translateOnDictionaryChangeEventSubscription" {
    name = "translate-on-dictionary-change"
    scope = azurerm_storage_account.storageAccount.id

    included_event_types = [ "Microsoft.Storage.BlobCreated" ]

    azure_function_endpoint {
      function_id = "${azurerm_linux_function_app.translationFunction.id}/functions/translation-function"
    }

    subject_filter {
      subject_begins_with = "/blobServices/default/containers/${azurerm_storage_container.dbContainer.name}/blobs/"
      subject_ends_with = "en.json"
    }
}