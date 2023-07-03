# Acquisition de données avec DAS240 et EA 9200U 

Travail présenté à l'ENSEIRB-MATMECA dans l'Institut National Polytechinique de Bordeaux comme stage de deuxiéme année, realisé au Laboratoire de l’Intégration du Matériau au Système (IMS) et au Institut de mécanique et d’ingénierie (I2M).

Auteur : Lucas Furlan
Encadrants : Stéphane Victor, Jean-Luc Battaglia et Andrzej Kusiak.

## Introduction

Celui est un programme labVIEW qui a été conçu pour commander l'entrée e l'acquisition de données appliqué à un système thermique. Il utilise une alimentation à haut rendement de la série EA-PSI 9200-25 et un enregistreur de données Sefram DAS 240. La communication avec le premier est faite à aide du protocole Modbus USB et le deuxième utilise le Modbus TCP-IP. Dans le cadre de l'implatation de cette interface, il est importante remarquer que un cable ethernet commun **ne peut pas être utilisé** : il faut un cable ethernet croisé ou un switch (ce qui a été utilisé).

## Drivers et packages

Le dossier << code >> contien tous les fichiers labVIEW pour l'utilisation du programme. Par contre, il est absolutment nécessaire télecherger et installer les drivers et packages pour faire la communication avec les deux machines. Pour ce dernier, il faut suivre le procedure suivant :

1. Executer le installateur du driver PSI9000 2U USB disponible sur le lien << https://elektroautomatik.com/shop/en/service/downloads/ps-9000-t1u2u3u/ >>. Il faut choisir la bonne version de l'alimentation.
2. Télechargez le package labVIEW pour la source disponible dans le site web << https://elektroautomatik.com/shop/en/service/downloads/labVIEW/ >>. Copiez et collez le dossier IF-XX avec tous ses fichier dans le dossier des packages labVIEW. Normalement, il est localisé dans le même dossier que labVIEW a été installé, par example : << C:Programmes(x86)\NationalInstruments\labview (version)\instr.lib >>. Attention, **ne créez pas un autre dossier**.
3. Télechargez le package labVIEW pour le DAS240, disponible dans le site << http://sine.ni.com/apps/utf8/niid_web_display.download_page?p_id_guid=61E0FD2D0F9757F5E05400144FF8B3F6 >>. Dans la même maniére que précedement, copiez et colez le dossier avec le packet dans *\instr.lib*. Attention, **ne créez pas un autre dossier**.
4. Télechargez et executez le installateur du package NVISA, disponible en << https://www.ni.com/fr-fr/support/downloads/drivers/download.ni-visa.html#480875 >>. Il permetra d'utiliser les utils de connexion TCP/IP disponibles pour labVIEW. Il est toujours possible de le faire hors ligne. IL est aussi remarcable que il faut choisir une version compatible avec le packet labVIEW du item précédente.
5. Télechargez et installer le *Sefram Viewer*, diponible dans le lien << https://www.sefram.com/en/software-updates.html >>.

## Configuration du DAS240

Ouvrez le NI MAX et allez sur << Créer un ressource TCP/IP >>. Choisissez l'entrée manuelle de l'adresse et de la porte et entrée ceux du DAS240. 

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/NIMAX.png)

L'adresse peut être changé dans le menu de *setup* de l'apareil et la porte sera toujours la 23. Normalement, il utilisera le *Dynamic Host Configuration Protocol* (DHCP), qui est un protocole client/serveur qui fournit automatiquement une adresse Internet Protocol (IP). Il est donc recomendable de fixé l'adresse pour éviter des problémes futures par rapport au processus de configuration du VISA.

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/TCPIP.bmp)

Cliquez sur << finir >> et vérifié que l'entité a été bien créé. Après, allez dans << ourvir open VISA panneau >>. Le même panneau est aussi acessible dans NI-VISA Iteractive control, dans le menu initial. Das cette panneau, il sera possible commander déjà l'acquisition de données : choisissez la commande << *IDN?\n >> et cliquez sur << query >>. Si tout a été bien configuré, le DAS240 envoyerá ses coordonées qu'on pourrait voir à l'écran.

Une fois tous fait et installé, il reste la configuration du DAS240.

## En utilisant le logiciell

Un fois que le programme va être executé, l'user doit voir dans l'écran la face avant du VI. Elle est constitué d'une partie de génération de données à gauche et d'aquisition de données à droite. Dans un premier temps, il faut régler la connecxion avec la alimentation : dans le champ << Numéro de la machine voulue >> il faut entrer le numéro de série de la machine connecté. Si vous ne savez pas ne numéro de série, il faut executer le code un fois (avec des autres paramètres non réglé) et note la troisième colune qui aparaître dans << Machines trouvées >>. 

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/mainVIp_markedS.png)

La génération de données pseudo aléatoire (PRBS) peut être faite soit avec labVIEW il-même, en specifient les valeurs de fréquence et emplitude, soit avec la lecture d'un fichier CSV. Dans le dernier cas, il faut especifié le chemin pour le fichier voulu, sachant qu'il ne contiendra qu'un vector d'echantillons et l'information temporelle sera donné par la fréquence d'échantillonage. Pour générer le signal avec labVIEW, les caracteristiques suivantes doivent être especifiées :

- Fréquence d'echantillonage : fréquence dans laquelle la source de alimentation va changer sa valeur en sortie ; 
- Fréquence maximale : elle sera a fréquence maximale dans le signal crée. Dans une DSP, elle correspondra à la fréquence du lobe principal. Ella doit être toujours plus petite que la fréquence d'échantillonage décrite avant ;
- Temps de simulation : temps total de simulation voulu. Le nombre d'échantillon sera donc égale à fréquence d´échantillonage*temps de simulation. Pour temps aussi longs, il faut peut être régler le histoire des graphes déroulantes ;
- Amplitude maximale et amplitude minimale : ils vont être le niveau de tension maximale et le niveau de tension minimale generé par la source, sachant que le niveau minimale doit être toujours positive.

Un fois que les informations de la géneration de données ont été créer, il faut régles les informations de l'acquisition. Premierment, il faut trouver l'adresse IP du DAS 240 : il est necessaire aller dans << setup >> dans le menu du enrigestreur. L'adresse apairaîtra à gauche.



Après, il faut entrer la fréquence d'échantillonage et aussi le nom de la analyse à être faite. Le données acquis seront enregistrés dans le doissier défaut << output >> et peut être aussi changé. Comme dernière partie, il faut dire la température de sécurité au-dessus dont la source d'alimentation será etendu dans << Température maximale >>.

Lorsque le code va être executé, il faut attendre les deux leds vertes carrées qui vont s'allumer lorsque la source d'alimentation et le sistème d'acquisition ont être trouvé et sont bien connecté. Aprés, le logicielle générera la PRBS et le dernier LED vert (le circulaire) s'allumera. Si aucune message d'erreur a aparu et les trois LEDs sont allumés, l'utilisateur peut cliquer sur << COMMENCER >>.

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/mainVIp_markedL.png)



Lorsque le code a été lancé, pour l'arreter **<span style="color: red;">il faut absolument cliquer sur << ARRÊTER >></span>** pour qu'il puisse arrêter la source de tension quelque soit la tension de sortie dans le moment. Avant de commancer la simulation, l'utilisateur peut voir le deux graphes qui sont présentes à gauche : le signal d'entrée chargé/généré et l'approximation de sa DSP avec la FFT.

## Données acquis
Do the frequency analysis for the transfert function F(s). Two different analysis are avaiable with 1D and 3D models. In both the Pade approximation for e^x and for some orders are shown and compared with respect to the non approximated solution.