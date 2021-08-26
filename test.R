function (sql_query, database_name, username, password, kdm_directory = "/tmp", 
          hive_config_file = "hive_config.json") 
{
  library(reticulate)
  kinit_cmd = paste("echo ", username, " | kinit ", password, 
                    sep = "")
  system(kinit_cmd)
  system("klist")
  library(rjson)
  json_loc = paste(kdm_directory, "/", hive_config_file, sep = "")
  json_data_frame <- fromJSON(file = json_loc)
  host_cmd = paste("sudo runuser -l root -c \"echo ", json_data_frame$KERBEROS_SERVICE_IP, 
                   " ", json_data_frame$KEREROS_SERVICE_ALIAS, " >> /etc/hosts \"", 
                   sep = "")
  system(host_cmd)
  Sys.setenv(HIVE_HOSTNAME = json_data_frame$KEREROS_SERVICE_ALIAS)
  hive <- import("pyhive.hive")
  pd <- import("pandas")
  conn = hive$connect(host = json_data_frame$KEREROS_SERVICE_ALIAS, 
                      port = as.integer(json_data_frame$KERBEROS_PORT), auth = json_data_frame$KERBEROS_AUTH, 
                      kerberos_service_name = json_data_frame$KERBEROS_SERVICE_NAME, 
                      username = json_data_frame$KERBEROS_HIVE_USERNAME, scheme = json_data_frame$KERBEROS_HTTP_SCHEME, 
                      database = database_name)
  response = pd$read_sql(sql_query, conn)
  return(response)
}