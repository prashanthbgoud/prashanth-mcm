
execute 'stop application' do
  command './scpp-ant.sh stop'
  cwd '/apps/scope/ca/distribution'
end

# Now attempt to apply all the fixpacks one by one

execute 'Starting to apply Deployment Director fixpacks' do
  command './updater.sh apply -updatepath "/apps/scope/mmc-workspace/CA_20_8690232270555423094_apply_fixpack/LEVIEOM_1B20161214_063130.zip" -targetpath /apps/scope/ca/distribution -tempdir /apps/scope/mmc-workspace/CA_20_8690232270555423094_apply_fixpack/dd_temp/'
  cwd '/apps/scope/mmc-workspace/sd2-tools/DeploymentDirector/updater/'
end

# Remove the remote fixpack

execute 'Remove the remote fixpack' do
  command 'rm -f LEVIEOM_1B20161214_063130.zip'
  cwd '/apps/scope/mmc-workspace/CA_20_8690232270555423094_apply_fixpack/'
end

execute 'Attempting to redeploy application' do
  command './scpp-ant.sh redeploy'
  cwd '/apps/scope/ca/distribution'
end

execute 'Attempting to start application' do
  command './scpp-ant.sh start'
  cwd '/apps/scope/ca/distribution'
end
