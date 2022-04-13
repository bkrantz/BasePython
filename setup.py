from setuptools import setup, find_packages

with open("README.md", "r") as readme_file:
    readme = readme_file.read()

requirements = [
]

setup(
    name="py_sample",
    version="0.0.1",
    author="Ben Krantz",
    author_email="krantz.benjamin.bus@gmail.com",
    description="Base Python Application",
    long_description=readme,
    long_description_content_type="text/markdown",
    packages=find_packages(),
    install_requires=requirements,
    classifiers=[
        "Programming Language :: Python :: 3.7",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
    ],
)