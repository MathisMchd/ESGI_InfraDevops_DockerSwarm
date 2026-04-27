const request = require('supertest');
const app = require('./index');

describe('API Tests', () => {
  describe('GET /', () => {
    it('should return hostname in JSON format', async () => {
      const response = await request(app)
        .get('/')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('hostname');
      expect(typeof response.body.hostname).toBe('string');
      expect(response.body.hostname.length).toBeGreaterThan(0);
    });
  });

  describe('GET /health', () => {
    it('should return OK status in JSON format', async () => {
      const response = await request(app)
        .get('/health')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toEqual({ status: 'OK' });
    });
  });
});