from flask import Flask, request, jsonify
import os

app = Flask(__name__)

@app.route('/send-audio/', methods=['POST'])
def send_audio():
    # Check if a file was uploaded
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'})
    
    file = request.files['file']
    
    # Save the file to disk
    newFilePath = os.path.join(os.getcwd(), 'recording.aac')
    file.save(newFilePath)
    
    # Do some processing with the audio file here...
    
    # Return a JSON response
    return jsonify({'date': '5/2/2023', 'WPM': 0.0, 'Matched WPM': 0.0, 'Mean Pauses': 0.0, 'STDev Pauses': 0.0, 'Intelligibility': 'Poor'})

if __name__ == '__main__':
    app.run(debug=True)
