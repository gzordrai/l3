## Rapport pour le TP1

# UDP : 

-- Question 1 :

ip -brief address show :
192.168.5.54/24

-- Question 2 : 

3

-- Question 3 et 4 :

-- Question 6 :

L'ip et le port de destination

-- Question 7 : 

-- Question 8 : 

Il est préférable de laisser la machine chosir le port de la destination.

-- Question 9 : 

0.0.0.0/0

-- Question 12 : 

127.0.0.1

-- Question 13 :

-- Question 14 :

-- Question 15 :

- c) 2 segment UDP ont été transmis.

# TCP 

-- Question 4 : 

On constate que la connexion est refusée.

-- Question 6 : 

La socket client : S1 et la socket serveur : S2 

-- Question 7 : 

2 ACK sont partis de chaque coté. c'est une double poignée de main.

-- Question 9 :

Une nouvelle socket est apparue.

-- Question 11 : 

- a) Il n'y aurai aucune données envoyées si PSH n'avait pas été activé.

- b) C'est des numéro qui permettent d'identifié des paquets et le celui qui reçoit peut demandé des numéro de paquets s'il lui en manque.

- c) C'est le numéro de la séquence reçu.

- d) la différence entre le numéro de séquence du paquet envoyé le numéro d'acquittement du paquet reçu correspond a la data envoyée.

-- Question 12 : 

le champ Recv-Q associé à la connexion précédemment établie contient la valeur 25.

-- Question 13 :

C'est l'identifiant renvoyé par la commande accept

-- Question 14 : 

la valeur du champ Recv-Q est maintenant de 0.

-- Question 15 : 

S1 ne peut plus emettre mais peut encore recevoir.

-- Question 17 : 

la socket envoie un paquet pour mettre fin a la connexion.

-- Question 18 : 

- b) 7 segments, pour chaque message on a 2 fois plus qu'avec UDP.



