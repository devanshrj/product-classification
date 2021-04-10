echo "Creating new virtual environment"
python -m venv venv

echo "Activating venv"
source venv/bin/activate

echo "Installing the required libraries"
pip install -r requirements.txt

python -m spacy download en_core_web_sm
