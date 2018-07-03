# scripts
 ### To setup ludo-dvamps
 ``curl https://raw.githubusercontent.com/tpkalyan/scripts/master/setup-ludo-dvamps.sh | sh``

 ### To setup dhis2 in debian
 #### Installing curl
  ``apt-get update && apt-get install curl -y``
  #### Actual setup
  ``curl https://raw.githubusercontent.com/tpkalyan/scripts/master/dhis_setup/dhis_setup_phase_1.sh -o dhis_setup_phase_1 && sh dhis_setup_phase_1``

  ``curl https://raw.githubusercontent.com/tpkalyan/scripts/master/dhis_setup/dhis_setup_phase_2.sh -o dhis_setup_phase_2 && sh dhis_setup_phase_2``

  ``curl https://raw.githubusercontent.com/tpkalyan/scripts/master/dhis_setup/dhis_setup_phase_3.sh -o dhis_setup_phase_3 && sh dhis_setup_phase_3``
