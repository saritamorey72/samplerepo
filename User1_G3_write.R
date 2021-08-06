fileConn<-file("/test_mosaic/G3/data_wrire.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)
