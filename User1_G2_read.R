fileConn<-file("/test_mosaic/G2/data_write.txt")
readLines(("/test_mosaic/G2/data_write.txt"), fileConn)
close(fileConn)