

  Hey Github, these are the instructions for Dtex - the textual db manager!

  Commands > ad - 'add data'
           > gd - 'get data'
           > rd - 'remove data'
           > fields - displays all fields at first line (csv file)

  'get data' command line options:

        gd [ -k >key< or --key >key< ] -> displays all avaliable informations about this key.

        gd [ -c >key< or --collumn >key< ] -> displays a single collumn

        gd [ -a or --all ] -> just 'cat' the csv file

  the The textual database is based on primary keys, as the first element of a data line:


      |--------------------------------|
      |  pk:name:aftername:home        |
      |  1:frodo:baggins:shire         |
      |  2:elrond:half-elven:rivendell |
      |________________________________|

	> Quick Review <


	[pcname@user]$  DATA=example.csv

	[pcname@user]$  source dtex.sh

        [pcname@user]$  fields

        name
        frodo
        elrond

        [pcname@user]$  gd --key 2

        name: elrond
        aftername: half-elven
        home:  rivendell


_______________ Versions _______________
----------------------------------------


  v1.0 -> innitial version

  v1.1
