function prob = GaussianProb(X, sigma, mu)

    pMatrix = 1/((2*pi) * sqrt(det(sigma))) ...
        * exp(-0.5*(bsxfun(@minus,X,mu)) * sigma^-1 *...
        (bsxfun(@minus,X,mu))');
   
    prob = diag(pMatrix);
    
    
    
end