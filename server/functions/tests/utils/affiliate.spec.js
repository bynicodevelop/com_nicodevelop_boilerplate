const {formatAffiliateCode} = require('../../utils/affiliate');

describe('Affiliate.js', () => {
  it('Doit retourner un code affilié formatté', () => {
    const datasets = [
      1, 23, 456, 7890, 12345,
    ];

    datasets.forEach((dataset) => {
      const result = formatAffiliateCode(dataset);

      expect(result).toEqual(dataset.toString().padStart(4, '0'));
    });
  });
});
