function output=interArrivalTimeTable(col)
    % Matrix I stores inter-arrival time & range of customer 
    I=zeros(2,col);
    
    % Get & Store service time
    fprintf('Inter-arrival Time ');
    for i=1:col
        %Pre-defined time starting from 1
        I(1,i)=i;
        fprintf('%2.0f\t\t\t\t\t',[I(1,i)]);
    end
        
    % Get probability
    P=probability(col);
    fprintf('\nProbability         ');
    for i=1:col
        fprintf('%2.2f\t\t\t',P(i));
    end

    % Get cdf
    CDF(1)=P(1);
    fprintf('\nCDF               \t\t%2.2f\t\t\t',CDF(1));
    for i=2:col
        CDF(i)=CDF(i-1)+P(i);
        fprintf('%2.2f\t\t\t',CDF(i));
    end
    
    % Get & Store Range(Upper bound)
    fprintf('\nRange             \t');
    lower=1;
    for i=1:col
        upper=CDF(i)*100;
        I(2,i)=upper;
        fprintf('%2.0f-%2.0f\t\t',[lower upper]);
        lower=upper+1;
    end
    
    fprintf('\n\n');
    
    output=I;
