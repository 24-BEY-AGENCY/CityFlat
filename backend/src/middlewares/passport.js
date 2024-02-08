import passport from "passport";
import GoogleStrategy from "passport-google-oauth20";
import userDb from "../models/user.model.js";
import generateRandomPassword from "../controllers/user.controller.js";
import sendTheRandomPasswordEmail from "../controllers/mailling.controller.js";
import bcrypt from "bcrypt";

export default function Passport() {
  passport.use(
    new GoogleStrategy(
      {
        clientID:
          "843910407535-pokc53vech7ec59r8e5kfp0dddtg1r0s.apps.googleusercontent.com",
        clientSecret: "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",
        callbackURL:
          "https://citynew.onrender.com/user/api/sessions/oauth/google",
      },
      function (accessToken, refreshToken, profile, cb) {
        console.log(
          "trying to acess a google account!",
          profile,
          profile.emails[0].value
        );
        userDb
          .findOne({})
          .or([{ googleID: profile.id }])
          .then((exists) => {
            if (exists) {
              return cb(null, exists);
            } else {
              const passw = generateRandomPassword(6);
              let newUser = {
                name: profile.displayName,
                email: profile.emails[0].value,
                password: bcrypt.hashSync(passw, 10),

                isVerified: true,

                img: profile.photos[0].value,

                googleID: profile.id,
              };

              sendTheRandomPasswordEmail(newUser, passw);

              userDb.create(newUser);
            }
          })
          .catch((err) => console.log(err.message));
      }
    )
  );
  passport.serializeUser(function (user, done) {
    done(null, user.id);
  });

  passport.deserializeUser(function (id, done) {
    userDb.findById(id, function (err, user) {
      done(err, user);
    });
  });
}
