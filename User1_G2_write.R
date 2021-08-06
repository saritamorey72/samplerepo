fileConn<-file("/test_mosaic/G2/data_write.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)
