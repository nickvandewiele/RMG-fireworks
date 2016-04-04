# coding: utf-8
import os
import logging
import argparse
from jinja2 import Environment, PackageLoader


def parseCommandLineArguments():

    parser = argparse.ArgumentParser()
    parser.add_argument('--wd', metavar='WD', type=str,
        help='The working directory that will contain the output of the RMG simulations.')
    parser.add_argument('--fw', metavar='FW', type=str,
        help='The installation directory of the RMG-fireworks project')
    
    args = parser.parse_args()
    return args

def main(cases, wd, fireworks_install):
    env = Environment(loader=PackageLoader('generate', 'templates'))

    template = env.get_template('input.yaml')

    casedict = [
                {'name': case, 'i_bm': (i+1)*3, 'i_tt': (i+1)*3+1, 'i_ch': (i+1)*3+2, }
                for i, case in enumerate(cases)
                ]


    output = template.render(
        cases   = casedict,
        wd      = wd,
        fw      = fireworks_install,
        )

    # print output
    output_file = 'rmg.yaml'
    with open(output_file,'w') as f_out:
        logging.info('Writing output to: {}'.format(output_file))
        f_out.write(output)

if __name__ == '__main__':
    # Parse the command-line arguments (requires the argparse module)
    args = parseCommandLineArguments()

    cases = ['eg1', 'eg3', 'eg5', 'eg6', 'eg7', 'MCH', 'methane', 'NC', 'solvent_hexane']
    logging.info('Generating yaml file for the following cases: {}'.format(cases))
    
    wd = args.wd or '~/fw_sims'
    fireworks_install = args.fw

    assert os.path.exists(fireworks_install), 'Could not find the specified RMG-fireworks directory...'

    main(cases, wd, fireworks_install)