# Caractérisation et identification de capteurs de flux en conditions extrêmes  

Travail présenté à l'ENSEIRB-MATMECA dans l'Institut National Polytechinique de Bordeaux comme stage de deuxiéme année, realisé au Laboratoire de l’Intégration du Matériau au Système (IMS) et au Institut de mécanique et d’ingénierie (I2M).

Auteur : Lucas Furlan
Encadrants : Stéphane Victor, Jean-Luc Battaglia et Andrzej Kusiak.

## Labview thermal identification

Celui est un programme Labview qui a été conçu pour commander l'entrée e l'acquisition de données appliqué à un système thermique. Il utilise une alimentation à haut rendement de la série EA-PSI 9200-25 et un enregistreur de données Sefram DAS 240. La communication avec le premier est faite à aide du protocole Modbus USB et le deuxième utilise le Modbus TCP-IP. Dans le cadre de l'implatation de cette interface, il est importante remarquer que un cable ethernet commun **ne peut pas être utilisé** : il faut un cable ethernet croisé ou un switch (ce qui a été utilisé).

### Drivers et packages

Le dossier << labview main project >> contien tous les fichiers labview pour l'utilisation du programme. Par contre, il est absolutment nécessaire télecherger et installer les drivers et packages pour faire la communication avec les deux machines. Pour ce dernier, il faut suivre le procedure suivant :

1. Executer le installateur du driver PSI9000 USB ;
2. Copiez et collez le dossier IF-XX avec tous ses fichier dans le dossier des packages Labview. Normalement, il est localisé dans le même dossier que labView a été installé, par example : << C:Programmes(x86)\NationalInstruments\LabVIEW (version)\instr.lib >>.
3. Télechargez et executez le installateur du package NVISA, disponible en << https://www.ni.com/fr-fr/support/downloads/drivers/download.ni-visa.html#480875 >>. Il permetra d'utiliser le package Modbus Master pour le protocolle TCP-IP. Cette partie peut prendre du temps.
4. Installer le Modbus avec le JKI VI Package Manager (VIPM), en utilisant le lien << https://www.ni.com/fr-fr/support/downloads/tools-network/download/unpackaged.modbus-master.374378.html >>. Il sera necessaire se connecter avec une compte d'utilisateur NI.


### En utilisant le logiciell

Un fois que le programme va être executé, l'user doit voir dans l'écran la face avant du VI. Elle est constitué d'une partie de génération de données à gauche et d'aquisition de données à droite. Dans un premier temps, il faut régler la connecxion avec la alimentation : dans le champ << Numéro de la machine voulue >> il faut entrer le numéro de série de la machine connecté. Si vous ne savez pas ne numéro de série, il faut executer le code un fois (avec des autres paramètres non réglé) et note la troisième colune qui aparaître dans << Machines trouvées >>. 

![Alt text](https://github.com/FurlanLucas/Stage2A/blob/main/mdFig/mainVIp_markedS.png)

La génération de données pseudo aléatoire (PRBS) peut être faite soit avec Labview il-même, en specifient les valeurs de fréquence et emplitude, soit avec la lecture d'un fichier CSV. Dans le dernier cas, il faut especifié le chemin pour le fichier voulu, sachant qu'il ne contiendra qu'un vector d'echantillons et l'information temporelle sera donné par la fréquence d'échantillonage. Pour générer le signal avec Labview, les caracteristiques suivantes doivent être especifiées :

- Fréquence d'echantillonage : fréquence dans laquelle la source de alimentation va changer sa valeur en sortie ; 
- Fréquence maximale : elle sera a fréquence maximale dans le signal crée. Dans une DSP, elle correspondra à la fréquence du lobe principal. Ella doit être toujours plus petite que la fréquence d'échantillonage décrite avant ;
- Temps de simulation : temps total de simulation voulu. Le nombre d'échantillon sera donc égale à fréquence d´échantillonage*temps de simulation. Pour temps aussi longs, il faut peut être régler le histoire des graphes déroulantes ;
- Amplitude maximale et amplitude minimale : ils vont être le niveau de tension maximale et le niveau de tension minimale generé par la source, sachant que le niveau minimale doit être toujours positive.

Un fois que les informations de la géneration de données ont été créer, il faut régles les informations de l'acquisition. Premierment, il faut trouver l'adresse IP du DAS 240 : il est necessaire aller dans << setup >> dans le menu du enrigestreur. L'adresse apairaîtra à gauche.

![Alt text](https://github.com/FurlanLucas/Stage2A/blob/main/mdFig/TCPIP.bmp)

Après, il faut entrer la fréquence d'échantillonage et aussi le nom de la analyse à être faite. Le données acquis seront enregistrés dans le doissier défaut << output >> et peut être aussi changé. Comme dernière partie, il faut dire la température de sécurité au-dessus dont la source d'alimentation será etendu dans << Température maximale >>.

Lorsque le code va être executé, il faut attendre les deux leds vertes carrées qui vont s'allumer lorsque la source d'alimentation et le sistème d'acquisition ont être trouvé et sont bien connecté. Aprés, le logicielle générera la PRBS et le dernier LED vert (le circulaire) s'allumera. Si aucune message d'erreur a aparu et les trois LEDs sont allumés, l'utilisateur peut cliquer sur << COMMENCER >>.

![Alt text](https://github.com/FurlanLucas/Stage2A/blob/main/mdFig/mainVIp_markedL.png)

Lorsque le code a été lancé, pour l'arreter **il faut absolument cliquer sur << ARRÊTER >>** pour qu'il puisse arrêter la source de tension quelque soit la tension de sortie dans le moment. Avant de commancer la simulation, l'utilisateur peut voir le deux graphes qui sont présentes à gauche : le signal d'entrée chargé/généré et l'approximation de sa DSP avec la FFT.

## freqAnalysis
Do the frequency analysis for the transfert function F(s). Two different analysis are avaiable with 1D and 3D models. In both the Pade approximation for e^x and for some orders are shown and compared with respect to the non approximated solution.