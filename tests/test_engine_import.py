import unittest
import importlib

ENGINES = [
    'lammps',
    'openfoam',
    'kratos',
    'jyulb']

class TestEngineImport(unittest.TestCase):

    def test_engine_import(self):
        for engine in ENGINES:
            importlib.import_module('simphony.engine',engine)
