# Rapport pour le TP4 : Liaison de données


## Adressage

1. Sur votre machine, quel est le nom de l’interface connectée au réseau de la salle de TP ? Quelle est son
adresse IPv4 ? Quelle est son adresse IPv6 ? Quelle est son adresse MAC ?

    Interface:  eth1
    IPV4:       192.168.5.54/24
    IPV6:       fe80::e654:e8ff:fe59:77bd/64
    MAC:        e4:54:e8:59:77:bd

    cmd:        `ip a`

2. Donnez les principales caractéristiques de cette interface : quelle est sa vitesse actuelle ? Est-ce la vitesse
maximale supportée par l’interface ? Quel le mode de duplex ? Vérifiez que l’interface est bien
connectée.

    Vitesse actuelle:       1000Mb/s
    Vitesse max:            1000Mb/s
    Mode duplex:            Full
    Interface connectée:    Oui

    cmd:                    `sudo ethtool eth1`

3. Quelle est la classe de l’adresse IPv4 ? Quel est son masque ? Quelle est l’adresse du réseau au format
CIDR ? Quelle est l’adresse de broadcast ? Combien d’hôtes peut-on adresser sur ce réseau ? Cette
adresse est-elle routable au sein d’un réseau local ? Est-elle routable sur internet ?

    Classe IPV4:            C
    Masque:                 255.255.255.0
    CIDR:                   /24
    Broadcast:              192.168.5.255
    Hôtes:                  254
    Routable en local:      Oui
    Routable sur internet:  Non

    cmd:                    `sudo ethtool eth1`

4. Écrivez les 16 octets de l’adresse IPv6 sans abréviation. Écrivez en dessous les 16 octets du masque.
Combien d’hôtes peut-on adresser sur ce réseau ? Cette adresse est-elle routable au sein d’un réseau
local ? Est-elle routable sur internet ? Quelle est l’étendue (scope) de cette adresse ?

    IPV6:                       fe80:0000:0000:0000:e654:e8ff:fe59:77bd
    Masque:                     ffff:ffff:ffff:ffff:0000:0000:0000:0000
    Hôtes:                      2 ^ (128-64) - 1
    Routable en local:          Oui
    Routable sur internet:      Non, car scope link (routable que en local)
    Etendue de cette adresse:   Adresse de lien local (scope link)

   Affichez la table de routage. Quelle est l’adresse de la passerelle IP ?

    Gateway:                    192.168.5.54

    cmd:                        `ip route`

5. Avec Wireshark, lancez une capture de trames sur l’interface connectée au réseau de la salle de TP.
Testez la connectivité IPv4 et IPv6 avec votre voisin.

    IPV4:   ping 192.168.5.55
    IPV6:   ping -6 -I eth1 fe80::e654:e8ff:fe59:672b

6. Arrêtez la capture . La transmission qui nous intéresse est noyée parmi d’autres trames qui nous
parasitent.
Pour simplifier la lecture, filtrez la capture de manière à ce que soient affichées uniquement les trames
émises par votre machine ou à destination de votre machine. Attention : les trames ethernet ne
contiennent pas toujours un paquet IP.
Pour savoir comment utiliser les filtres d’affichage, référez-vous à l’aide de Wireshark :
[https://www.wireshark.org/docs/wsug_html_chunked/ChWorkDisplayFilterSection.html](https://www.wireshark.org/docs/wsug_html_chunked/ChWorkDisplayFilterSection.html)

    Filtre: `ip.addr == 192.168.5.55`

7. Quel est le protocole utilisé pour tester la connectivité IP ? Ce protocole est le couteau suisse d’IP. Il ne
sert pas seulement à tester la connectivité IP. Quel est le type et le code des messages de requête et de
réponse ?

    Protocole:  ICMP
    Type:       IPV4
    Code:       0x0009 

    cmd:        ping 192.168.5.55

8. La plupart des protocoles réseau permettent, dans l’entête, de spécifier quel est le type du contenu
véhiculé.
Donnez le code du contenu de la trame ethernet.
Donnez le code du contenu du paquet IP.

   Les paquets IP transmis à votre voisin sont encapsulés dans des trames ethernet. Pour que ces trames parviennent à destination, il faut connaître l’adresse ethernet de votre voisin. Cette adresse est aussi appelée adresse matérielle ou adresse MAC (Media Access Control), ou encore adresse de couche liaison..

    Code trame eternet: 0x0800 (IPv4)
    Code paquet IP:     1 (ICMP)

9. Avant l’envoi du ping IPv4, un échange de messages ARP (Address Resolution Protocol) a eu lieu. Quelle
est l’adresse matérielle de destination de la requête ? Que signifie cette adresse ? Quelle est la question
posée par la requête ?

    Adresse:        e4.54.e8.59.5f.b2
    Signification:  C'est l'adresse de la machine qu'on ping
    Question:       Who has 192.168.5.55 ?

    cmd: `ping 192.168.5.55`, `ip neigh`

10. Avant l’envoi du ping IPv6, un échange de messages ICMPv6 de type Neighbor Solicitation et Neighbor
Advertisement a eu lieu. Quelle est l’adresse matérielle de destination de la requête ? Que signifie cette
adresse ? Quelle est l’adresse IP de destination de la requête ? A quoi correspond cette adresse ?

    Adresse MAC de destination: e4.54.e8.59.5f.b2
    Signification:              C'est l'adresse MAC du destinataire
    
    IP de destination:          fe80::e654:e8ff:fe59:672b
    Signification:              Elle correspond à l'adresse IP du destinataire

11. Affichez la liste des correspondances entre adresses IP et adresses ethernet. Vérifiez que l’adresse IPv4 et
l’adresse IPv6 de votre voisin y figurent, associées à son adresse MAC. Attention : les entrées de ce cache
ont une durée de vie limitée à quelques minutes.

    192.168.5.1 dev eth1 lladdr 00:87:31:21:35:74 DELAY
    192.168.5.56 dev eth1 lladdr e4:54:e8:59:86:a8 STALE
    192.168.5.64 dev eth1 lladdr e4:54:e8:59:7c:b5 STALE
    192.168.5.71 dev eth1 lladdr e4:54:e8:59:50:75 STALE
    192.168.5.59 dev eth1 lladdr e4:54:e8:59:85:7f STALE
    192.168.5.70 dev eth1 lladdr e4:54:e8:59:85:85 STALE
    192.168.5.69 dev eth1 lladdr e4:54:e8:59:67:fb STALE
    192.168.5.55 dev eth1 lladdr e4:54:e8:59:67:2b STALE
    192.168.5.57 dev eth1 lladdr e4:54:e8:59:7d:f7 STALE
    192.168.5.65 dev eth1 lladdr e4:54:e8:59:67:ee STALE
    192.168.5.60 dev eth1 lladdr e4:54:e8:59:7b:6a STALE
    192.168.5.68 dev eth1 lladdr e4:54:e8:59:7c:d7 STALE
    fe80::e654:e8ff:fe59:672b dev eth1 lladdr e4:54:e8:59:67:2b STALE

    cmd: `ip neigh`

12. A quelles couches du modèle OSI appartiennent les protocoles ethernet, IP, ICMP ?

    IP:     Réseau
    ICMP:   Réseau

13. Selon vous, de manière générale, pourquoi utilise-t-on l'adresse IP et non uniquement l'adresse MAC pour
les communications réseaux ?

    Parce que l'adresse MAC correspond à la carte réseau alors que le l'IP à la machine

## Point-à-point

Chaque machine de la salle dispose d’au moins 2 interfaces ethernet. Laissez votre machine connectée à la prise EXT, qui vous permet d’atteindre internet ou votre homedir. Utilisez une autre interface ethernet pour la connecter à la machine de votre voisin, en point-à-point, via la
baie de brassage.

1. Vous utilisez un câble droit ou un câble croisé ?

    Cable:  croisé

2. Quelle commande utilisez-vous pour vérifier que votre interface est bien connectée, et connaître la vitesse
et le mode de duplex qui ont été négociés entre vos deux machines ?

    cmd:    `sudo ethtool eth0`

3. Affectez une adresse IPv4 privée de classe A à l’interface ethernet. Notez qu’une adresse IPv6 est déjà
associée à cette interface. Elle a été configurée automatiquement.

    Vous remarquerez qu’une même interface réseau peut très bien être associée à plusieurs adresses IP.

    cmd:    `sudo ip address add 10.0.0.2/24 dev eth0 && sudo ip link set dev eth0 up`

4. Affichez la table de routage. Que constatez-vous ?

    On constate une nouvelle ligne: `10.0.0.0/24 dev eth0 proto kernel scope link src 10.0.0.2 linkdown`

    cmd:    `ip route`

5. Testez la connectivité avec votre voisin.

    cmd: `ping 10.0.0.3`

## Concentrateur (hub)

Brassez votre poste de travail sur le concentrateur (hub) situé dans la baie de brassage.
Assurez-vous que deux de vos voisins y sont connectés également.
Supprimez les filtres de capture et d'affichage préalablement configurés.

1. Lancez une capture de trames sur un poste, et transmettez un ping entre les deux autres postes. Que
constatez-vous ? Déduisez-en la manière dont les données sont transmises par cet équipement. Les
données émises par un poste sont-elles reçues par ce même poste ?

    Chaque machine voit les communications sur le hub

2. Recommencez la manipulation en désactivant le mode promiscuous de wireshark. A quoi sert-il ?

    Le mode promiscuous sert à voir tous les paquets sur le réseau y compris ceux qui ne nous sont pas destinés

3. Quel est le mode de duplex des interfaces connectées au hub ? Quelle en est la signification ?

    Duplex: Half
    Cela signifie que on peut communiquer dans les 2 sens mais pas en simultané.

4. Quelles sont les topologies physique et logique du réseau constitué par le concentrateur et les postes qui y
sont connectés ?

    **Remplacez cette phrase avec votre réponse.**

5. Lancez la commande « iperf -s » sur un poste et « iperf -c ip_du_serveur » sur un autre poste pour lancer
un test de bande passante. Notez le débit atteint et les valeurs du compteur de collisions (voir annexe)
avant et après la manipulation.
Connectez un poste supplémentaire sur le hub (soit au minimum 4 postes) et réalisez de nouveau la manip
en parallèle sur les deux paires de postes.
Notez le débit atteint et les nouvelles valeurs des compteurs de collisions. Déduisez-en la manière dont
fonctionne un hub.

    **Remplacez cette phrase avec votre réponse.**

   Les postes connectés entre eux via des concentrateurs forment un **domaine de collision**.


## Commutateur (switch)

Brassez votre poste de travail sur le commutateur (switch) situé dans la baie de brassage.
Assurez-vous que deux de vos voisins y sont connectés également.
Supprimez les filtres de capture et d'affichage préalablement configurés.
Réactivez le mode promiscuous.

1. Lancez une capture de trames sur un poste, et transmettez un ping entre les deux autres postes. Que
constatez-vous ? Déduisez-en la manière dont les données sont transmises par cet équipement.

    **Remplacez cette phrase avec votre réponse.**

2. Quel est le mode de duplex des interfaces connectées au hub ? Quelle en est la signification ?

    **Remplacez cette phrase avec votre réponse.**

3. Quelles sont les topologies physique et logique du réseau constitué par le concentrateur et les postes qui y
sont connectés ?

    **Remplacez cette phrase avec votre réponse.**

4. Lancez la commande « iperf -s » sur un poste et « iperf -c ip_du_serveur » sur un autre poste pour lancer
un test de bande passante. Notez le débit atteint et les valeurs du compteur de collisions (voir annexe)
avant et après la manipulation.
Connectez un poste supplémentaire sur le switch (soit au minimum 4 postes) et réalisez de nouveau la
manip en parallèle sur les deux paires de postes.
Notez le débit atteint et les nouvelles valeurs des compteurs de collisions. Déduisez-en la manière dont
fonctionne un switch.

    **Remplacez cette phrase avec votre réponse.**

    Pour paramétrer les équipements réseau et obtenir des informations sur leur configuration, il faut établir une
liaison série entre votre poste de travail et le port console de l'équipement en question.
Cette liaison permet d'établir une connexion dite « hors bande », c'est-à-dire en dehors de la bande passante
du réseau ethernet.
Connectez-vous sur le port console d'un switch, noté Sx-C (avec x=R,J,B ou V selon votre baie de brassage).
Utilisez pour cela un câble série DB9-RJ45 (câble bleu et plat) et lancez le programme « minicom ».

    Une fois connecté, tapez sur la touche « entrée » pour afficher le prompt. Si la question « voulez-vous lancer
le setup du switch ? » vous est posée, répondez « non ».
Vous êtes actuellement en mode USER EXEC (prompt >), qui ne permet de lancer qu'un nombre réduit de
commandes, que vous pouvez lister en tapant « ? ». Passez en mode privilégié (prompt #), puis affichez la
table de commutation.

5. Comparez les adresses MAC listées avec celles de vos postes et les ports du switch sur lesquels ils sont
connectés. Comment le switch a-t-il obtenu ces adresses ? Quel est le rôle de la table de commutation
(appelée aussi table d'adresses MAC) ?

    **Remplacez cette phrase avec votre réponse.**

6. Pour fonctionner correctement, le switch a-t-il besoin de connaître les adresses mac des trames ? les
adresses IP des paquets ? Déduisez-en à quels niveaux du modèle OSI interviennent un switch et un hub
et quelles sont les unités de données sur lesquelles ils agissent.

    **Remplacez cette phrase avec votre réponse.**

7. Concluez sur les avantages du switch par rapport au hub.

    **Remplacez cette phrase avec votre réponse.**

8. Selon vous, en fonctionnement normal, une interface d’un commutateur peut-elle être associée au même
moment à plusieurs addresses ethernet ? Une même adresse ethernet peut-elle être associée au même
moment à plusieurs interfaces d’un commutateur ?

    **Remplacez cette phrase avec votre réponse.**

9. Lancez maintenant une capture de trames sur plusieurs postes connectés au switch et transmettez un ping
vers l'adresse IP 255.255.255.255. Que constatez-vous ? Comment s'appelle ce type de transfert ? Quelle
est l'adresse ethernet de destination des trames reçues ?

    **Remplacez cette phrase avec votre réponse.**

10. Envoyez un ping vers l’adresse ff02::1. Que constatez-vous ? Comment s'appelle ce type de transfert ?
Quelle est l'adresse ethernet de destination des trames reçues ?

    **Remplacez cette phrase avec votre réponse.**

    Un commutateur permet de segmenter les domaines de collisions.
Les postes connectés par l'intermédiaire de commutateurs constituent un **domaine de broadcast**.


## Routeur

Choisissez 2 sous-réseaux IPv4 de classe B. Veillez à ce qu’ils soient différents de votre voisin.
Complétez le schéma suivant en affectant une adresse IP aux interfaces, l’objectif étant que les postes
puissent communiquer ensemble.

![topologie](topologie.png)

Connectez 3 postes, 1 switch et 1 routeur en suivant ce schéma.

1. Configurez les adresses IP sur les interfaces en vous référant à l’annexe.

    **Remplacez cette phrase avec votre réponse.**

2. Ajoutez une route sur les postes de manière à ce que les postes 1 et 2 puissent communiquer avec le 3.

    **Remplacez cette phrase avec votre réponse.**

3. Après avoir lancé une capture de trames sur les postes 2 et 3, lancez un ping depuis le poste 1 vers le
poste 2, puis vers le poste 3 (voir schéma). Il s'agit d'un transfert unicast. Comparez les valeurs du champ
TTL de l'entête IP des paquets reçus sur les postes 2 et 3. Pourquoi sont-elles différentes ? Quelle est
l'utilité de ce champ ?

    **Remplacez cette phrase avec votre réponse.**

4. Quelle devrait être la valeur du TTL pour que le poste 1 puisse communiquer avec le poste 2, mais pas
avec le poste 3 ? Vérifiez votre réponse en envoyant, depuis le poste 1, un ping avec ce TTL vers les
postes 2 et 3 (voir « man ping »).
Lancez une capture sur le poste 1 et envoyez un ping du poste 1 vers le poste 3 en conservant le TTL que
vous avez choisi. Que se passe-t-il ?

    **Remplacez cette phrase avec votre réponse.**

5. Lancez de nouveau un ping depuis le poste 1 vers le poste 3. Quelles sont l'adresse MAC source de la
trame reçue (sur le poste 3) et l'adresse MAC de destination de la trame envoyée (à partir du poste 1) ?
Selon vous, à quelles interfaces ethernet correspondent ces adresses ? Pour vous aider, lancez la
commande « show interface fastethernet » sur le routeur.

    **Remplacez cette phrase avec votre réponse.**

6. Comment le poste 1 a-t-il su que la trame ethernet contenant le paquet IP à destination du poste 3 devait
être envoyée au routeur ?

    **Remplacez cette phrase avec votre réponse.**

7. Dessinez un schéma des couches OSI utilisées dans chaque équipement mis en jeu dans le transfert
unicast (2 postes, 1 switch et 1 routeur), et tracez une ligne représentant le flux de données passant d'un
équipement à l'autre (communication horizontale) en traversant les couches (communication verticale).

    **Remplacez cette phrase avec votre réponse.**

8. Lancez une capture de trames sur les 3 postes et lancez un ping depuis le poste 1 vers l'adresse
255.255.255.255. Il s'agit d'un transfert en diffusion limitée (broadcast). Que constatez-vous ?

    **Remplacez cette phrase avec votre réponse.**

9. Lancez une capture de trames sur les 3 postes et lancez un ping depuis le poste 3 vers l'adresse de
broadcast du réseau sur lequel se trouvent les postes 1 et 2. Que constatez-vous ?

    **Remplacez cette phrase avec votre réponse.**

    Exécutez les commandes suivantes sur le routeur : <br>
    _Router(config)#interface fastEthernet 0/0_ <br>
    _Router(config-if)#ip directed-broadcast_

10. Recommencez la manipulation précédente. Il s'agit d'un transfert en diffusion dirigée. Que constatez-
vous ? Quelle est l'adresse IP de destination des paquets reçus ? Selon vous, pourquoi ce mode de
transfert est-il désactivé par défaut ?

    **Remplacez cette phrase avec votre réponse.**

11. Quelle est la différence entre diffusion limitée, diffusion dirigée et unicast.

    **Remplacez cette phrase avec votre réponse.**

12. Comment un routeur réagit à ces différents types de paquets ? Concluez sur la différence entre un routeur
et un switch vis-à-vis de la diffusion IP.

    **Remplacez cette phrase avec votre réponse.**

13. Reliez votre routeur à celui de votre voisin de manière à ce que touts les machines puissent communiquer
ensemble.

    **Remplacez cette phrase avec votre réponse.**
