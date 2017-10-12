#!/usr/bin/env python3

# Parameters: <domain> <problem> <domain_name> <til_adjustment>
# Implements the baseline approach: takes as input a PDDL domain and file, and
# 1. Adjusts the timestamps of the TILs by til_adjustment
# 2. Calls a planner on the new problem
# 3. Adjusts the timestamps on the resultsing plan
# 4. Calls VAL to check the new plan
# Returns 0 if this works, non-zero otherwise

from concurrent.futures import ThreadPoolExecutor
from tqdm import tqdm
import math

class Configuration:

   def __init__(self, domain, problem, memory_limit, time_limit, adjustment):
        self.domain = domain
        self.problem = problem
        self.memory_limit = memory_limit
        self.time_limit = time_limit
        self.adjustment = adjustment


class Result:

   def __init__(self, configuration, success, error):
        self.configuration = configuration
        self.success = success
        self.error = error


def create_adjusted_problem(domain, problem, adjustment):
    pass


def execute_planner(domain, problem, limits):
    pass


def remove_adjstment(adjusted_plan):
    pass


def execute_configuration(configuration):
    pass


def execute_configurations(configurations, threads=1):
    progress_bar = tqdm(total=len(configurations))
    if threads == 1:
        results = []
        for configuration in configurations:
            results.append(execute_configuration(configuration))
            progress_bar.update()
        return results
    
    futures = []
    with ThreadPoolExecutor(max_workers=threads) as executor:
        for configuration in configurations:
            future = executor.submit(execute_configuration, configuration)
            future.add_done_callback(lambda _: progress_bar.update())
            futures.append(future)

    return [future.result() for future in futures]


def process_results(results):
    # Plot data
    pass


def generate_configurations():
    # We probably want to replace the hardcoded parts
    domain = '/home/aifs2/bence/development/projects/temporal_planning_and_execution/resources/DOMAINS/trucks/TimeConstraints/Time-TIL/domain.pddl'
    problem = '/home/aifs2/bence/development/projects/temporal_planning_and_execution/resources/DOMAINS/trucks/TimeConstraints/Time-TIL/p01.pddl'
    memory_limit = 4000000
    time_limit = 1800
    adjustments = ['smart', 1e0, 1e1, 1e2, 1e3]

    return [Configuration(domain=domain, problem=problem, memory_limit=memory_limit, time_limit=time_limit, adjustment=adjustment) for adjustment in adjustments]

def main():
    configurations = generate_configurations()
    results = execute_configurations(configurations)
    process_results(results)


if __name__ == "__main__":
    main()
