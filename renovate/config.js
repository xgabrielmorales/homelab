module.exports = {
  platform: 'forgejo',
  endpoint: 'https://git.xgabrielmorales.com/api/v1/',
  token: process.env.RENOVATE_TOKEN,
  repositories: ['xgabrielmorales/homelab'],
  binarySource: 'global',
  onboarding: false,
  requireConfig: 'ignored',
  hostRules: [
    {
      hostType: 'github',
      token: process.env.GITHUB_TOKEN
    },
    {
      hostType: 'docker',
      username: process.env.DOCKERHUB_USERNAME,
      password: process.env.DOCKERHUB_TOKEN
    }
  ],
  customManagers: [{
    customType: 'regex',
    managerFilePatterns: ['/(^|/)swarm/.*/compose\\.yml$/', ],
    matchStrings: ['image:\\s*["\']?(?<depName>[^\\s@:\'"]+):(?<currentValue>[^\\s@:\'"]+)(?:@(?<currentDigest>sha256:[a-f0-9]{64}))?["\']?'],
    datasourceTemplate: 'docker'
  }],
  packageRules: [
    {
      matchManagers: ['custom.regex'],
      minimumReleaseAge: '3 days'
    }
  ]
};
