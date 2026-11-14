# Ticketmania: pruebas de rendimiento

## Qué hace el pipeline
Con cada push a main, o a mano, GitHub Actions levanta una máquina Ubuntu e instala Java 17 y JMeter 5.6.3. Arranca la API de Python en el puerto 8080 y espera a que /api/salud responda. Luego ejecuta el plan en modo no-GUI (200 usuarios, 300 s de subida) desde pruebas/jmeter/, para que encuentre boletas.csv. Revisa el .jtl y deja el job en rojo si hay peticiones fallidas, porque JMeter por sí solo no lo hace. Siempre sube el reporte HTML como artefacto.

## Qué armé yo y qué revisé con el tutor
Armé el workflow paso a paso con mi chat bot configurado como IA tutor. El tutor me explicó cada paso y me entregó varios bloques completos: instalación de JMeter, levantar la API, esperar la API, ejecutar JMeter, revisar resultados y subir el reporte. Yo preparé el plan (200 hilos, subida de 300 s, CSV con ruta relativa), lo probé en local, creé la estructura del repo y el .gitignore, hice el push y verifiqué la ejecución en Actions.

## Cómo verifiqué el reporte
En Actions, el job terminó en Success y quedó el artefacto reporte-jmeter. En el reporte vi 600 muestras (200 usuarios × 3 peticiones), 0 % de error y una media de 3,84 ms. Si una petición fallara, el paso “Revisar resultados” saldría con exit 1 y el job quedaría en rojo. El reporte se subiría igual por if: always().