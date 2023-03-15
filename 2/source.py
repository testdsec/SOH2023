app.config.update(
    SESSION_COOKIE_HTTPONLY=False
)

@app.route('/register', methods=['POST'])
def register():
    email = request.form.get('email')
    username = request.form.get('username')
    password = request.form.get('password')
    db.execute("INSERT INTO accounts VALUES (NULL, '%s', '%s', '%s')" % (username, password, email))
    db.commit()
    msg = f'Hi {username}! You have successfully registered!'
    return render_template_string(msg)


@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')
    db.execute("SELECT * FROM accounts WHERE username = '%s' AND password = '%s'" % (username, password,))
    account = db.fetchone()
    if account:
        session['loggedin'] = True
        session['id'] = account['id']
        session['username'] = account['username']
        return 'Logged in successfully !'
    else:
        return 'Incorrect username or password!'

@app.route('/admin', methods=['GET'])
def profile():
    if session:
        id = session['id']
    else:
        return 'You are not authorized'
    db.execute('SELECT * from accounts WHERE id = %d' % id)
    account = db.fetchone()
    if account['username'] == 'admin':
        return 'Admin Panel'
    else:
        return 'You are not admin'

app.run(debug=True)
