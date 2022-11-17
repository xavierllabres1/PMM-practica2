# PMM - Pràctica2

## CFGS DAM - CIFP Pau CasesNoves (2022)

Aquesta pràctica és senzilla però funcional. Enlloc de cercar widgets random per omplir el cupo, s'ha optat per cercar algun element mínimament coherent amb l'app. Per això si la app te dues pàgines una amb les dades d'usuari, l'altre ens permet configurar l'aspecte visual. Permetent fer canvis a través del paquet colorpicker (on s'ha emprat un widget AlertDialog) i el canvi de tamany del text, a través del PopupMenuButton.

L'app, principalment s'ha basat en que funcioni correctament, tenint especial cura: 
- A l'hora d'introduir la data (no es pot introduïr una data de naixament posterir a avui). 
- Un avatar amb les inicial a la pàgina d'usuari, que s'ajusten (i no peta) quan algun camp esta en blanc.
- No deixa guardar l'usuari si te el camp nom en blanc, o el correu electrònic te un format incorrecte.
- Mostra missatges d'alerta (AlertDialog).
- Possibilitat de modificar aspectes visuals.
