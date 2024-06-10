function output = serviceTimeTable(col)
    % Matrix C stores service time & range of each counter   
    C = zeros(6, col);
    
    bayIndex = 1;
    
    % Loop for 3 counters, each counter takes up 2 rows of the matrix
    for bay = 1:2:6
        fprintf('Wash bay %1.0f:\n', bayIndex);
        
        % Get & Store service time
        fprintf('Service Time ');
        for i = 1:col
            % All counters start from 1
            C(bay, i) = i;
            fprintf('%2.0f\t\t\t\t\t', [C(bay, i)]);
        end
            
        % Get probability
        P = probability(col);
        fprintf('\nProbability   ');
        for i = 1:col
            fprintf('%2.2f\t\t\t', P(i));
        end

        % Get cdf
        CDF(1) = P(1);
        fprintf('\nCDF         \t\t%2.2f\t\t\t', CDF(1));
        for i = 2:col
            CDF(i) = CDF(i-1) + P(i);
            fprintf('%2.2f\t\t\t', CDF(i));
        end
        
        % Get & Store Range (Upper bound)
        fprintf('\nRange       \t');
        lower = 1;
        for i = 1:col
            upper = CDF(i) * 100;
            C(bay + 1, i) = upper;
            fprintf('%2.0f-%2.0f\t\t', [lower upper]);
            lower = upper + 1;
        end
        
        fprintf('\n\n');
        bayIndex = bayIndex + 1;
    end
    
    output = C;
end
