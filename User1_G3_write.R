fileConn<-file("/test_mosaic/G2/data_wrire.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)
