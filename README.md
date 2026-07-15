# Terraform Azure Learn 🚀

Personal hands-on learning repo for real-world Azure infrastructure practice using Terraform.

> **Stack:** Terraform `>= 1.3.0` · AzureRM `~> 4.0` · Azure `japaneast` · Auth via Azure CLI

---

## 🎯 Goal

- Learn Terraform hands-on with Azure — resource by resource
- Build real-world Azure infrastructure patterns using IaC best practices

---

## 📚 Progress

| # | Resource | Folder | Status |
|---|---------|--------|--------|
| 1 | Resource Group | `rg/` | ✅ Done |
| 2 | Virtual Network + Subnet | `vnet/` | ✅ Done |
| 3 | Network Security Group + Association | `nsg/` | ✅ Done |
| 4 | Storage Account + Container | `storage/` | ✅ Done |
| 5 | Virtual Machine (Linux) + Public IP + NIC | `vm/` | ✅ Done |
| 6 | Managed Identity (User Assigned) | `managed-identity/` | ✅ Done |
| 7 | RBAC Role Assignment | `rbac/` | ✅ Done |
| 8 | Key Vault + Secrets | `key-vault/` | ✅ Done |
| 9 | App Service Plan + App Service | `app-service/` | ✅ Done |
| 10 | PostgreSQL Flexible Server + Database | `postgresql/` | ✅ Done |
| 11 | Private Endpoint + Private DNS Zone | `private-endpoint/` | ✅ Done |
| 12 | Service Endpoint + Storage Account | `service-endpoint/` | ✅ Done |
| 13 | Application Gateway | `app-gateway/` | ✅ Done |

---

## 🏗️ Folder Structure

Each resource folder follows this pattern:

```
<resource-name>/
├── provider.tf              # Terraform + AzureRM provider config
├── main.tf                  # Resource definitions
├── variables.tf             # Input variable declarations
├── outputs.tf               # Output values
├── terraform.tfvars         # Actual values (gitignored)
└── terraform.tfvars.example # Template for values
```

---

## 🔑 Key Concepts Covered

| Concept | Where |
|---------|-------|
| `data source` — reference existing resources | `vnet/`, `nsg/`, `vm/` |
| Implicit dependency | `vnet/` — Subnet depends on VNet |
| `sensitive = true` — hide secrets in output | `vm/`, `key-vault/` |
| `locals` — reusable name strings | `app-gateway/` |
| Private Endpoint + DNS Zone + DNS Link + A Record | `private-endpoint/` |
| Service Endpoint — Subnet level | `service-endpoint/` |

---

## 🚀 How to Use

```bash
# 1. Clone the repo
git clone https://github.com/SharifMahin/terraform-azure-handson-full-architecture.git

# 2. Go to any resource folder
cd rg/

# 3. Copy example vars and fill in your values
cp terraform.tfvars.example terraform.tfvars

# 4. Login to Azure
az login

# 5. Initialize Terraform
terraform init

# 6. Preview changes
terraform plan

# 7. Deploy
terraform apply

# 8. Destroy when done (save cost!)
terraform destroy
```

---

## 🔒 Security Notes

- `terraform.tfvars` is **gitignored** — never commit real values
- Passwords marked `sensitive = true` in variables
- Managed Identity used instead of hardcoded credentials where possible

---

## 👤 Author

**MD SHARIF MULLA MAHIN**
Cloud Lead Engineer
Tokyo, Japan 🇯🇵