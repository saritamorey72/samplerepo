fileConn<-file("/test_mosaic/G3/data_writee.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)
