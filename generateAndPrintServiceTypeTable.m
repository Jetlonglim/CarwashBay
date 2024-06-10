function output = generateAndPrintServiceTypeTable(col)
    % Define the service types and their probabilities
    serviceTypes = {'Type 1', 'Type 2', 'Type 3'};
    probabilities = probability(col);

    % Calculate cumulative probabilities (CDF)
    cumulativeProbabilities = cumsum(probabilities);

    % Print the service type table header
    fprintf('Service Type Table:\n');
    fprintf('%-15s', 'Service Type');
    for i = 1:col
        fprintf('%-15s', ['Type ' num2str(i)]);
    end
    fprintf('\n');

    % Print probabilities
    fprintf('%-15s', 'Probability');
    for i = 1:col
        fprintf('%-15.2f', probabilities(i));
    end
    fprintf('\n');

    % Print cumulative probabilities (CDF)
    fprintf('%-15s', 'CDF');
    for i = 1:col
        fprintf('%-15.2f', cumulativeProbabilities(i));
    end
    fprintf('\n');

    % Print ranges
    fprintf('%-15s', 'Range');
    lower = 0;
    for i = 1:col
        upper = cumulativeProbabilities(i) * 100;
        fprintf('%-15s', [num2str(lower) '-' num2str(upper)]);
        lower = upper + 1;
    end
    fprintf('\n\n');

    output = cumulativeProbabilities;
end
