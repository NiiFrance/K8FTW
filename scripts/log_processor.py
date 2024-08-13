import re
from datetime import datetime

def process_logs(file_path):
    error_logs = []
    
    # Regular expression to match the log format
    log_pattern = re.compile(r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) \[(\w+)\] (.+)')
    
    with open(file_path, 'r') as file:
        for line in file:
            match = log_pattern.match(line)
            if match and match.group(2) == 'ERROR':
                date_str, _, message = match.groups()
                date = datetime.strptime(date_str, '%Y-%m-%d %H:%M:%S')
                error_logs.append((date, message))
    
    # Sort logs by date
    error_logs.sort(key=lambda x: x[0])
    
    # Format and print the results
    for date, message in error_logs:
        print(f"{date.date()} {message}")

# Usage
process_logs('sample.log')