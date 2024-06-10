function output=probability(n)
    cdf=0;

    div=1/(n+1);
    offset=div;
    
    upper=div+offset;
    lower=1/n*0.65;
    
    for i=1:n-1
        P(i)=round((rand()*(upper-lower)+lower)*100)/100;
                
        if (P(i) > div)
            offset=offset-(P(i)-div);
            upper=div+offset;
        end

        cdf=cdf+P(i);        
    end
    
    P(n)=1-cdf;
    
    output=P;
