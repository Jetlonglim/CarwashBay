function printSimulationTable(C)
    numCars = size(C, 1); % Determine the number of cars
    fprintf('::::::::::::: Customer Arrival Time :::::::::::::\n');
    fprintf('+----+---------------+---------------+---------+-----------------+\n');
    fprintf('| n  | RN for Inter- | Inter-arrival | Arrival | Service         |\n');
    fprintf('|    | arrival time  | time          | Time    | Type            |\n');
    fprintf('+----+---------------+---------------+---------+-----------------+\n');
    
    % Print details for all customers
    for i = 1:numCars
        fprintf('| %2.0f |     %3.0f       |      %2.0f       |  %4.0f   |       %2.0f        |\n', [C(i, 13) C(i, 2) C(i, 3) C(i, 4) C(i, 5)]);
        fprintf('+----+---------------+---------------+---------+-----------------+\n');
    end
    
    fprintf('\n\n');

    % Exhibit message customer arrival and departure
    fprintf('::: Time to time message ::: \n')
    % Record timestamps for all activities
    timestamp = zeros(1, size(C, 1) * 3);
    cusNum = 1;
    for i = 1:3:size(C, 1) * 3
       timestamp(i) = C(cusNum, 4); % arrival time
       timestamp(i + 1) = C(cusNum, 9); % service time begins
       timestamp(i + 2) = C(cusNum, 10); % service time ends
       cusNum = cusNum + 1;
    end
    % Remove duplicated times
    timestamp = unique(timestamp);

    % Display the messages for each timestamp
    for t = 1:length(timestamp)
        time = timestamp(t);
        for i = 1:size(C, 1)
            if time == C(i, 10)
                fprintf('Departure of customer %d at minute %d.\n', C(i, 13), C(i, 10));
            end
            if time == C(i, 4)
                fprintf('Arrival of customer %d at minute %d and queue at counter %d.\n', C(i, 13), C(i, 4), C(i, 1));
            end
            if time == C(i, 9)
                fprintf('Service for customer %d started at minute %d.\n', C(i, 13), C(i, 9));
            end
        end
        fprintf('\n');
    end    
    fprintf('\n');
    
    % Display the simulation table for each wash bay
    fprintf('::::::::::::: Wash bays Table :::::::::::::\n');
    for washbayNum = 1:3
        if washbayNum == 1
            fprintf('Wash bay %1.0f (Express Wash bay): \n', washbayNum);
        else
            fprintf('Wash bay %1.0f: \n', washbayNum);
        end
    
        fprintf('+----+-----------------+--------------+---------------+--------------+--------------+---------+----------------+\n');
        fprintf('| n  | RN Service Time | Service Time | Total Service | Time Service | Time Service | Waiting | Time spends in |\n');
        fprintf('|    | (per item)      | (per item)   | Time          | Begins       | Ends         | time    | the system     |\n');
        fprintf('+----+-----------------+--------------+---------------+--------------+--------------+---------+----------------+\n');
        for i = 1:size(C, 1)
            if C(i, 1) == washbayNum
                fprintf('| %2.0f |      %3.0f        |      %2.0f      |      %3.0f      |    %4.0f      |     %4.0f     | %4.0f    |      %4.0f      |\n', [C(i, 13) C(i, 6) C(i, 7) C(i, 8) C(i, 9) C(i, 10) C(i, 11) C(i, 12)]);
                fprintf('+----+-----------------+--------------+---------------+--------------+--------------+---------+----------------+\n');
            end
        end
        fprintf('\n');
    end
    
    % Evaluate the results of the simulation
    disp(' ');
    disp('==================================');
    disp(' Evaluation Results of Simulation ');
    disp('==================================');
    
    total_wait = 0;
    total_spent = 0;
    total_inter = 0;
    total_arrival = 0;
    item_serve = zeros(1, 3);
    total_serve = zeros(1, 3);
    serve_count = zeros(1, 3);
    wait_count = 0;
    
    for i = 1:size(C, 1)
        % Customers that have to wait
        if C(i, 11) > 0
            % total waiting time
            total_wait = total_wait + C(i, 11);  
            wait_count = wait_count + 1;
        end
        
        % total time spent
        total_spent = total_spent + C(i, 12);
      
        % total inter-arrival time  
        total_inter = total_inter + C(i, 3);
        
        % total arrival time
        total_arrival = total_arrival + C(i, 4);
        
        % total service time for each wash bay
        washbay = C(i, 1);
        total_serve(washbay) = total_serve(washbay) + C(i, 8);
        item_serve(washbay) = item_serve(washbay) + C(i, 7);
        serve_count(washbay) = serve_count(washbay) + 1;
    end
    
    % average service time for each washbay
    avg_item_serve = zeros(1, 3);
    avg_serve = zeros(1, 3);
    for i = 1:3
        if serve_count(i) > 0
            avg_item_serve(i) = item_serve(i) / serve_count(i);
            avg_serve(i) = total_serve(i) / serve_count(i);
        end
    end

    % average waiting time
    avg_wait = total_wait / size(C, 1);

    % average inter-arrival time
    avg_inter = total_inter / (size(C, 1) - 1);
    
    % average arrival time
    avg_arrival = total_arrival / size(C, 1);
    
    % average time spent
    avg_spent = total_spent / size(C, 1);
    
    % probability that a customer has to wait
    p_wait = wait_count / size(C, 1);
    
    % Display results
    fprintf('Average service time per item for express bay: %.2f\n', avg_item_serve(1));
    fprintf('Average service time per item for regular bay 1: %.2f\n', avg_item_serve(2));
    fprintf('Average service time per item for regular bay 2: %.2f\n', avg_item_serve(3));
    
    fprintf('Average service time for express bay: %.2f\n', avg_serve(1));
    fprintf('Average service time for regular bay 1: %.2f\n', avg_serve(2));
    fprintf('Average service time for regular bay 2: %.2f\n', avg_serve(3));
    
    fprintf('Average waiting time: %.2f\n', avg_wait);
    fprintf('Average inter-arrival time: %.2f\n', avg_inter);
    fprintf('Average arrival time: %.2f\n', avg_arrival);
    fprintf('Average time spent in system: %.2f\n', avg_spent);
    fprintf('Probability that a customer has to wait: %.2f\n', p_wait);
end
