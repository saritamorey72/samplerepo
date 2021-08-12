fileConn<-file("/test_mosaic/G1/user2_write_success.txt")
readLines(("/test_mosaic/G1/user2_write_success.txt"), fileConn)
close(fileConn)