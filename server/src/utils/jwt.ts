import jwt, { SignOptions } from 'jsonwebtoken';
import { config } from '../config';
import { JWTPayload, TokenPair } from '../types';

export const generateAccessToken = (payload: JWTPayload): string => {
  const options: SignOptions = {
    expiresIn: config.jwtExpire as SignOptions['expiresIn'],
  };

  return jwt.sign(payload, config.jwtSecret, options);
};

export const generateRefreshToken = (payload: JWTPayload): string => {
  const options: SignOptions = {
    expiresIn: config.jwtRefreshExpire as SignOptions['expiresIn'],
  };

  return jwt.sign(payload, config.jwtRefreshSecret, options);
};

export const generateTokenPair = (payload: JWTPayload): TokenPair => {
  return {
    accessToken: generateAccessToken(payload),
    refreshToken: generateRefreshToken(payload),
  };
};

export const verifyAccessToken = (token: string): JWTPayload => {
  return jwt.verify(token, config.jwtSecret) as JWTPayload;
};

export const verifyRefreshToken = (token: string): JWTPayload => {
  return jwt.verify(token, config.jwtRefreshSecret) as JWTPayload;
};