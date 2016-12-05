import unittest
import os
import logging

from stevedore.extension import ExtensionManager
import logging
import sys

root = logging.getLogger()
root.setLevel(logging.DEBUG)

ch = logging.StreamHandler(sys.stdout)
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
root.addHandler(ch)

ENGINES = [
    'lammps',
    'openfoam_file_io',
    'openfoam_internal',
    'kratos',
    'jyulb_fileio_isothermal',
    'jyulb_internal_isothermal',
    'liggghts']

if os.getenv("HAVE_NUMERRIN", "no") == "yes":
    ENGINES.append("numerrin")


class TestEngineImport(unittest.TestCase):

    def test_engine_import(self):
        extension_manager = ExtensionManager(namespace='simphony.engine')
        for engine in ENGINES:
            if engine not in extension_manager:
                self.fail("`{}` could not be imported".format(engine))
