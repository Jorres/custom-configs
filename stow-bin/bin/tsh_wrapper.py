#!/usr/bin/env python3

import argparse
import subprocess

from pathlib import Path

TSH_CONFIG_DIR=Path.home() / '.tsh'
TSH_CURRENT_PROFILE_FILE= TSH_CONFIG_DIR / 'current-profile'

BASTION_PROFILES={
        'man': 'bastion.man.nebiusinfra.net',
        'pa10': 'bastion.pa10.nebiusinfra.net',
        'root-prod': 'lb.prod.root.bastion.eu-north.nebiusinfra.net',
        'root-test': 'lb.test.root.bastion.eu-north.nebiusinfra.net'
}

UNSUPPORTED_PROFILE_ERROR = """
Using unsupported profile. You can still manually login to it, if you're sure:
tsh login --proxy=<proxy-address>:443
"""

HELP_MESSAGE = f"""
Usage: wrapper --bastion <bastion-alias> [<tsh-args> ...]

Tsh wrapper is a thin wrapper over tsh for managing profiles without relogins.

Flags:
    --bastion           profile alias {list(BASTION_PROFILES.keys())}

Examples:
    wrapper --bastion man ls
    wrapper --bastion pa10 ssh node-0001.ik8s.nbcore.net
"""

def set_current_profile(bastion_profile):
        if bastion_profile not in BASTION_PROFILES.keys():
            print(UNSUPPORTED_PROFILE_ERROR)
            exit(1)

        profile_config_file = Path(str(TSH_CONFIG_DIR / BASTION_PROFILES[bastion_profile]) + '.yaml')
        
        # If tsh is not configured to use selected profile - login to it.
        if not TSH_CONFIG_DIR.exists() or not profile_config_file.exists():
            res = subprocess.run(['tsh', 'login', '--proxy', BASTION_PROFILES[bastion_profile]])
            if res.returncode != 0:
                exit(res.returncode)
            return

        # Set current profile
        with open(Path.home() / TSH_CURRENT_PROFILE_FILE, 'w') as file:
            file.write(BASTION_PROFILES[bastion_profile])


def main():
    parser = argparse.ArgumentParser(add_help=False)

    parser.add_argument('--wrapper_help', action='store_true')
    parser.add_argument('--bastion', type=str)

    # Parse the arguments
    args, unknown = parser.parse_known_args()

    if args.wrapper_help:
        print(HELP_MESSAGE)
        exit(0)
    
    if args.bastion != None and args.bastion != "":
        set_current_profile(args.bastion)

    command = ['tsh']
    command.extend(unknown)
    
    if len(unknown) == 0 or '--help' in unknown or '-h' in unknown:
        print(HELP_MESSAGE)
        print("====================")

    res = subprocess.run(command)
    exit(res.returncode)


if __name__ == "__main__":
    main()

