param($eventGridEvent, $TriggerMetadata)

Write-Host "Event received: $($eventGridEvent.eventType) $($eventGridEvent.subject)"

Connect-AzAccount -Identity
Restart-AzWebApp -ResourceGroupName $env:ACPLATFORM_INT_RG_NAME -Name $env:ACPLATFORM_INT_BACKEND_NAME

Write-Host "Triggered restart"