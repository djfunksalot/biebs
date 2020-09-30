====================
Guided Data Analysis
====================

.. image:: http://newsie.net/biebs.png
    :target: https://en.wikipedia.org/wiki/Guided_analytics

=========================
Installation Instructions
=========================
Step 1: Clone this project

    git clone https://github.com/djfunksalot/biebs.git

Step 2: Install MongoDB

.. image:: https://webassets.mongodb.com/_com_assets/cms/mongodb_logo1-76twgcu2dm.png
    :target: https://docs.mongodb.com/manual/installation/


Step 3: Install R libraries
     install.packages(c('cognitoR','data.table','dplyr','DT','ggplot2','knitr','meta','metafor','metasens','mongolite','netmeta','rmarkdown','shiny','shinyBS','shinydashboard','shinyjs','shinyLP','xmeta'), repos='https://cloud.r-project.org/')

Step 4: Start R from the project directory and run it:

    shiny::runApp()

Step 5: If you would like to enable authentication, you'll need to follow the configuration instructions for `cognitoR`_.  Otherwise, only the user 'test' will be available.

.. _cognitoR: https://github.com/chi2labs/cognitoR/

============
Docker Image
============
You can also run this project using `docker-compose <https://docs.docker.com/compose/install/>`_

 cd docker &&
 docker-compose build &&
 docker-compose up
