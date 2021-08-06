

fileConn<-file("/test_mosaic/G1/user2_write_success.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)


