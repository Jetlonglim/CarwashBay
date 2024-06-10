function C = simulateFirstCustomer(prevArrivalTime, expressLimit, ST, S)
    % Calculate and Wash bay simulation details for the first customer as below:
    % C(n,1) = Bay number
    % C(n,2) = RN for inter-arrival time
    % C(n,3) = Inter-arrival time
    % C(n,4) = Arrival time
    % C(n,5) = Number of cars acquired
    % C(n,6) = RN service time
    % C(n,7) = Service time(per car)
    % C(n,8) = Total service time
    % C(n,9) = Time service begins
    % C(n,10) = Time service ends
    % C(n,11) = Waiting time
    % C(n,12) = Time spends in system
    % C(n,13) = Customer number
    
    % Initialize the simulation details for the first customer
    C = zeros(1, 13);
    
    % Set customer number
    C(1, 13) = 1;

    % Set number of items acquired (assuming AT represents the number of items acquired)
    C(1, 5) = prevArrivalTime;

    % Determine and set which bay the 1st customer goes to based on the number of items acquired and the express limit
    if C(1, 5) <= expressLimit
        C(1, 1) = 1; % Assign to express bay
    else
        C(1, 1) = 2; % Assign to regular bay
    end

    % Set RN for service time(per item)
    C(1, 6) = ST(1);

    % Based on RN and bay number, determine and set service time(per item)
    bay = C(1, 1);
    for i = 1:size(S, 2)
        if C(1, 6) <= S((bay - 1) * 2 + 2, i)
            C(1, 7) = S((bay - 1) * 2 + 1, i);
            break;
        end
    end

    % Calculate and set the total service time
    C(1, 8) = C(1, 7) * C(1, 5);

    % Calculate and set arrival time (assuming it's the arrival time of the previous customer plus the inter-arrival time)
    C(1, 4) = prevArrivalTime + C(1, 3);

    % Calculate and set time service begins (assuming it begins immediately upon arrival)
    C(1, 9) = C(1, 4); % Arrival time

    % Calculate and set time service ends
    C(1, 10) = C(1, 9) + C(1, 8);

    % Calculate and set time spends in the system (assuming no waiting time for the first customer)
    C(1, 11) = 0; % No waiting time for the first customer
    C(1, 12) = C(1, 8); % Time spends in the system is equal to the total service time
end
