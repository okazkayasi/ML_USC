function test_acc = testsvm(w, b, test_x, test_y)

   y_hat = sign(w'*test_x' + b);
   test_acc = mean(y_hat' == test_y);
end