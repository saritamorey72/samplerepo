

fileConn<-file("/test_mosaic/G1/data_wrire.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)


