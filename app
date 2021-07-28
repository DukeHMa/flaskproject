from os import name
from flask import Flask, redirect, url_for, render_template, request, session, flash
from datetime import timedelta



app = Flask(__name__)
app.secret_key = "Duke"
app.permanent_session_lifetime = timedelta(minutes=5)


        

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/login", methods=["POST", "GET"])
def login ():
    if request.method == "POST":
        session.permanent = True
        user = request.form["nm"]
        session["user"]= user
        flash("Login succesful")
        return redirect(url_for("user"))
    else:
        if "user" in session:
            flash("Already logged in!")
            return redirect(url_for("user"))
       
        return render_template("login.html")


@app.route("/user")
def user():
    email = None
    if "user" in session:
        user = session["user"]
        return render_template("user.html", user=user)
        
    else:
        flash("You are not logged in!")
        return redirect(url_for("login"))

@app.route("/logout")
def logout():
    user = session["user"]
    flash(f"you have been logged out, {user}",'info')
    session.pop("email", None)
    return redirect(url_for("login"))

if __name__=="__main__":
   
    app.run(debug=True)
