fileConn<-file("/test_mosaic/G3/data_write.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)
