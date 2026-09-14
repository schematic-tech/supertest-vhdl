"""Exercise each scenario in its own simulator process."""
import os
import subprocess
import unittest


class AuthoringTests(unittest.TestCase):
    def run_probe(self, mode):
        return subprocess.run(
            [os.environ.get("GHDL", "ghdl"), "-r", "--std=08", "authoring",
             f"-gtest_mode={mode}", "--assert-level=error"],
            cwd=os.environ.get("BUILD_DIR", "build"),
            capture_output=True, text=True, timeout=10,
        )

    def test_true_continues(self):
        result = self.run_probe(0)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("continued", result.stdout)

    def test_false_finishes_successfully(self):
        result = self.run_probe(1)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("entered", result.stdout)
        self.assertNotIn("continued", result.stdout)
        self.assertIn("status 0", result.stdout)

    def test_assertion_still_fails(self):
        result = self.run_probe(2)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("ordinary assertion failure", result.stdout + result.stderr)


if __name__ == "__main__":
    unittest.main()
