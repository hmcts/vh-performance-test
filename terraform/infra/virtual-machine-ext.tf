
locals {
  winscript = "powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) ;powershell choco install jmeter --ignore-checksums -y ; powershell exit 0"
}

resource "azurerm_virtual_machine_extension" "perf_test" {
  count = var.vm_instance_count

  name                 = "chocoInstall-${count.index + 1}"
  virtual_machine_id   = azurerm_windows_virtual_machine.perf_test[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PSETTINGS
    {
       "commandToExecute": "${local.winscript}"
    }
PSETTINGS

  tags = local.common_tagss
}