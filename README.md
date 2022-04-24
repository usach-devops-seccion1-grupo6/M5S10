# Requisito previo
* Usar azure
* Agregar el archivo provider.tf
# Uso

1. Dar a tu usuario el rol de administrador de aplicaciones. Active Directory>Roles y administradores> buscar el rol del "administrador de aplicaciones" y hacer click> clic "Agregar asignaciones>hacer clic en tu usuario> agregar

2. En el terminal desloguearse y luego loguearse (az logout y az login)
3. az ad sp create-for-rbac --name aksclusterprincipal
4. Copiar las credenciales appId y password, copiarlas en client_id y client_secret respectivamente.
5. ejecutar el plan y apply