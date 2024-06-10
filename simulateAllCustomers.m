function C = simulateAllCustomers(I, IAT, AT, expressLimit, ST, S)
    numCustomers = size(AT, 1);
    noOfColumn = size(I, 2);
    
    % Initialize the simulation details for all customers
    C = zeros(numCustomers, 13);

    for i = 1:numCustomers
        if i == 1
            % Handle the first customer separately 
            prevArrivalTime = 0;
            C(i, 3) = IAT(1); % Inter-arrival time for the first customer
        else
            % For subsequent customers, use i - 1 as index 
            prevArrivalTime = C(i - 1, 4);
            C(i, 3) = IAT(i - 1); % Inter-arrival time for subsequent customers
        end

        % Set customer number
        C(i, 13) = i;

        % Set number of items acquired (assuming AT represents the number of items acquired)
        C(i, 5) = AT(i);

        % Determine and set which bay the customer goes to based on the number of items acquired and the express limit
        if C(i, 5) <= expressLimit
            C(i, 1) = 1; % Assign to express bay
        else
            C(i, 1) = 2; % Assign to regular bay
        end

        % Set RN for service time(per item)
        C(i, 6) = ST(i);

        % Based on RN and bay number, determine and set service time(per item)
        bay = C(i, 1);
        for j = 1:size(S, 2)
            if C(i, 6) <= S((bay - 1) * 2 + 2, j)
                C(i, 7) = S((bay - 1) * 2 + 1, j);
                break;
            end
        end

        % Calculate and set the total service time
        C(i, 8) = C(i, 7) * C(i, 5);

        % Calculate and set arrival time
        C(i, 4) = prevArrivalTime + C(i, 3);

        % Calculate and set time service begins
        if i == 1
            C(i, 9) = C(i, 4); % Service begins at arrival time for the first customer
        else
            C(i, 9) = max(C(i, 4), C(i - 1, 10)); % Arrival time or time service ends of previous customer
        end

        % Calculate and set time service ends
        C(i, 10) = C(i, 9) + C(i, 8);

        % Calculate and set waiting time
        C(i, 11) = C(i, 9) - C(i, 4);

        % Calculate and set time spends in the system
        C(i, 12) = C(i, 8) + C(i, 11);
    end
end
