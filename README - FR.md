# Acquisition de données avec DAS240 et EA 9200U 

Travail présenté à l'ENSEIRB-MATMECA dans l'Institut National Polytechinique de Bordeaux comme stage de deuxième année, réalisé au Laboratoire de l'Intégration du Matériau au Système (IMS) et au Institut de mécanique et d'ingénierie (I2M).

Auteur : Lucas Furlan

Encadrants : Stéphane Victor, Jean-Luc Battaglia et Andrzej Kusiak.

## Introduction

Celui est un programme labVIEW qui a été conçu pour commander l'entrée et l'acquisition de données appliquée à un système thermique. Il utilise une alimentation à haut rendement de la série EA-PSI 9200-25 et un enregistreur de données Sefram DAS 240. La communication avec le premier est faite à aide du protocole Modbus USB et le deuxième utilise le Modbus TCP-IP. Dans le cadre de l'implantation de cette interface, il est important remarquer qu'un câble ethernet commun **ne peut pas être utilisé** : il faut un câble ethernet croisé ou un switch (ce qui a été utilisé).

## Drivers et packages

Le dossier `code` contient tous les fichiers labVIEW pour l'utilisation du programme. Par contre, il est absolument nécessaire télecharger et installer les drivers et packages pour faire la communication avec les deux machines. Pour ce dernier, il faut suivre la procedure suivant :

1. Executer l'installateur du driver PSI9000 2U USB disponible sur le lien « https://elektroautomatik.com/shop/en/service/downloads/ps-9000-t1u2u3u/ ». Il faut choisir la bonne version de l'alimentation.

2. Télechargez le package labVIEW pour l'alimentation disponible dans le site web « https://elektroautomatik.com/shop/en/service/downloads/labVIEW/ ». Copiez et collez le dossier IF-XX avec tous ses fichiers dans le dossier des packages labVIEW. Normalement, il est localisé dans le même dossier que labVIEW a été installé, par example `C:Programmes(x86)NationalInstrumentslabview (version)instr.lib`. Attention, **ne créez pas un autre dossier**.

3. Télechargez le package labVIEW pour le DAS240, disponible dans le site « http://sine.ni.com/apps/utf8/niid_web_display.download_page?p_id_guid=61E0FD2D0F9757F5E05400144FF8B3F6 ». De la même manière que précédemment, copiez et collez le dossier avec le packet dans *instr.lib*. Attention, **ne créez pas un autre dossier**.

4. Télechargez et exécutez l'installateur du package NVISA, disponible en « https://www.ni.com/fr-fr/support/downloads/drivers/download.ni-visa.html#480875 ». Il permettra d'utiliser les outils de connexion TCP/IP disponibles pour labVIEW. Il est toujours possible de le faire hors ligne. IL est aussi remarquable qu'il faut choisir une version compatible avec le packet labVIEW d'item précédente.

5. Télechargez et installer le *Sefram Viewer*, disponible dans le lien « https://www.sefram.com/en/software-updates.html ».

Une fois tous fait et installé, il reste la configuration du DAS240.

## Configuration du DAS240

Ouvrez le NI MAX et allez sur « Créer une ressource TCP/IP ». Choisissez l'entrée manuelle de l'adresse et de la porte et mettez ceux du DAS240.

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/NIMAX.png)

L'adresse peut être changée dans le menu de *setup* de l'appareil et la porte sera toujours la 23. Normalement, il utilisera le *Dynamic Host Configuration Protocol* (DHCP), qui est un protocole client/serveur qui fournit automatiquement une adresse Internet Protocol (IP). Il est donc recommandable de fixer l'adresse pour éviter des problèmes futures par rapport au processus de configuration du VISA.

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/TCPIP.bmp)

Cliquez sur « finir » et vérifié que l'entité a été bien créé. Après, allez dans « ouvrir VISA panneau ». Le même panneau est aussi accessible dans NI-VISA Iteractive control, dans le menu initial. Das ce panneau, il sera possible commander déjà l'acquisition de données : choisissez la commande « *IDN?n » et cliquez sur « query ». Si tout a été bien configuré, le DAS240 enverra ses coordonnées qu'on pourrait voir à l'écran.

## En utilisant le logiciell

Une fois le programme exécuté, l'utilisateur doit voir la face avant du VI à l'écran. Il se compose d'une partie génération de données à gauche et d'une partie acquisition de données à droite. Tout d'abord, vous devez établir la connexion avec la source d'alimentation : dans le champ "Numéro de la machine souhaitée" vous devez saisir le numéro de série de la machine connectée. Si vous ne connaissez pas le numéro de série, vous devez exécuter le code une fois (avec les autres paramètres non définis) et noter la troisième colonne qui apparaît dans « Machines trouvées ».

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/mainVIp_markedS.png)

Si le programme a été bien connecté avec succès à toutes les machines, les trois LEDs vertes seront allumées. La génération de données pseudo aléatoires (PRBS) peut être faite soit avec labVIEW lui-même, en spécifiant les valeurs de fréquence et d'amplitude, soit avec la lecture d'un fichier csv avec les instants d'échantillonnage. Si le premier est choisi, alors les paramètres suivants doivent être spécifiés :

* Fréquence maximale (Hz) : définir la fréquence maximale dans le PRBS, en donnant une période de temps minimale pour chaque partie du signal ;
* Amplitudes maximales et minimales (V) : définir les amplitudes du PRBS ;
* Temps de simulation : temps total de la simulation. Le nombre d'échantillonnages générés sera d'environ (temps de simulation) * (fréquence d'acquisition) ;
* Temps d'échantillonnage (Hz) : donne l'heure à laquelle la sortie est mise à jour dans la machine. Doit être supérieure à la fréquence maximale.

Un fois que les informations de la géneration de données ont été créer, il faut régles les informations de l'acquisition. Premierment, il faut trouver l'adresse IP du DAS 240 : il est necessaire aller dans « setup » dans le menu du enrigestreur. L'adresse apairaîtra à gauche.

Si un fichier CSV a été utilisé, seule la dernière option et l'emplacement du fichier doivent être spécifiés. Dans le coin inférieur gauche, le signal d'entrée sera affiché une fois généré, ainsi que son spectre de puissance.

Les données d'acquisition sont contrôlées par la partie droite (rouge) du programme. Les champs suivants doivent être remplis :

* Nom de l'analyse : nom du fichier dans le DAS240 ;
* Période d'échantillonnage : période d'acquisition du DAS240.

Le numéro d'analyse indique le numéro de l'analyse située dans le système d'acquisition et ne peut pas être modifié. Au-dessous de cette partie, les données acquises en temps réel seront affichées. Si la température dépasse la limite définie dans « température maximale », l'alimentation électrique sera automatiquement coupée. Il faut également préciser le coefficient du thermocouple.

Lorsque le code a été lancé, pour l'arreter **<span style="color: red;">il faut absolument cliquer sur « ARRÊTER »</span>** pour qu'il puisse arrêter la source de tension quelque soit la tension de sortie dans le moment. Avant de commancer la simulation, l'utilisateur peut voir le deux graphes qui sont présentes à gauche : le signal d'entrée chargé/généré et l'approximation de sa DSP avec la FFT.

## Données acquis

Les données acquis vont être enregistré dans le dossier donnée par « Chemin de sortie ». Si il n'existe pas, labVIEW va le crée le dossier. Par contre, il ne va créer que un dossier : si le chemin de sortie est `test/output` et tous les deux `test` et `output` n'existent pas, labVIEW vas accuser un erreur en sortie. Les fichiers enregistrée seron trois : 
- `nom_labview.csv `: fichier avec tous les données enregistré par labview ;
- `nom.rec` : fichier avec les données enregistré par DAS240 ;
- `nom.txt` : fichier converti de nom.rec par txt avec Sefram Viewer.

La récuperation des fichiers REC et la conversion par TXT sont faites dans le fichier takeFile.bat. 