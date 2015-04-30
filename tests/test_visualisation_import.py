import unittest
import importlib

PLUGINS = [
    'mayavi_tools']


class TestVisualisationPluginImport(unittest.TestCase):

    def test_plugin_import(self):
        for engine in PLUGINS:
            importlib.import_module('simphony.visualisation', engine)
